# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT83 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.26.tgz"
  sha256 "aed8d359d98c33723b65e4ba58e5422e5cf794c54fbd2241be31f83a49b44dde"
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e4a36a0cd1f2ded09cd1d3f1c2f98b6e9b4d8c418491f5407a175742f5b66e61"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "83272191be6a269ca9ce385f44cd52d66eceb56687f1641275978caf09bbfcea"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "059999fa4c25796f2abc3fe0949545a61f535c70e7e8621933c9607bd2c9457d"
    sha256 cellar: :any_skip_relocation, ventura:       "8f99e9f1a9bab6dd45f03cffbf6c9a7f0eb147e34224f671dc164428739daca0"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "11bb421478127b3b76782e1260e2113056f736c7229137a63dc32c07f87be2f6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "49af39c1c188469c2322c94857d171026862572352ed92403cb7d73001b3c359"
  end

  def install
    Dir.chdir "apcu-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-apcu"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
