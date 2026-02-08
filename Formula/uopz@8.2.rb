# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uopz Extension
class UopzAT82 < AbstractPhpExtension
  init
  desc "Uopz PHP extension"
  homepage "https://github.com/krakjoe/uopz"
  url "https://pecl.php.net/get/uopz-7.1.1.tgz"
  sha256 "50fa50a5340c76fe3495727637937eaf05cfe20bf93af19400ebf5e9d052ece3"
  head "https://github.com/krakjoe/uopz.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/uopz/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "d7c0f3ca771ea18fceed42564594ce7eeaef2273adf8db374b5b4c73d95a64a0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "48525b96630924a70302cab507a2f5999fa8d524cbf7e3a9acabfa5d0edc0b02"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "add9db0c1b75ac5f1877be16f2ce183c94cf3cf20167c6dc13d7d91c4e78a739"
    sha256 cellar: :any_skip_relocation, sonoma:        "e9db783bb69db7dd05fc32f047f41b6c981979cbb0d8691320a897cd71b22939"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c38b14c7bbee8c6a1e7e3b182d22f596a4555e04bf39b1a2177e0a5a8dd51fb2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0f488a475f54d74d44ba79b53e9b795fa9f855f1f564f19491ba0c02a96ecd2c"
  end

  priority "10"

  def install
    Dir.chdir "uopz-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-uopz"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
