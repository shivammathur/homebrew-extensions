# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT74 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.0.0RC3.tgz"
  sha256 "e83643078d59b7ba39fa7dded2f0d95abf0c872a85599538ed4214f58acdce40"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e3a95d192541a3a0029f761f60c70d92dec89edd5f78b4521c74d623f8e480c5"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "863974e0e4975c080d1051cb53cbe258ac577b700fe1c9e96d8465d4333f14b4"
    sha256 cellar: :any_skip_relocation, monterey:       "1804794a3cf3be4de29d64d0adaa00183686a324370e245521716ea9320979dd"
    sha256 cellar: :any_skip_relocation, big_sur:        "0cb0ecb69a7d2b9f156d88f30867ae6ba2cd46183e3524b7646fc434749158ba"
    sha256 cellar: :any_skip_relocation, catalina:       "f82362e2fa41b45fceabc7ecb0d263989ff5858dff8afdb382c70eef6ae5b887"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "401e401ab248d0a89d3b00e0e7ce15154f659fa14abcdab67061df6415dbb43e"
  end

  depends_on "pcre"

  def install
    Dir.chdir "phalcon-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
