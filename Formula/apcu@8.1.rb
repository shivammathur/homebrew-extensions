# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT81 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.23.tgz"
  sha256 "67ee7464ccad2335c3fa4aeb0b8edbcf6d8344feea7922620c6a13015d604482"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "b292a9e7f6bb5ab56dbaf6c07feeecff010ca5be03083fafacdef2f5a8174b5f"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d8dfb4b014a0c54d29ff694bd69a7f99161a4272403151509e3eb8b25dc446bb"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "830befbd72008eec95c7184673c6f94a21863d55010bc29900f4d7bf4b032e02"
    sha256 cellar: :any_skip_relocation, ventura:        "14e2fb9bcde716301c2baf4c264e5b8c4dfdb40d9a0d78d25c9b247c891c38c9"
    sha256 cellar: :any_skip_relocation, monterey:       "7ff73839fe596ac87ff789e873c070470a6aafc9c66aae57fddd421f7ab0db26"
    sha256 cellar: :any_skip_relocation, big_sur:        "e1bb824780e1b8a03c4999d1322d348a20e49dc2de37942cc41855c9391b6702"
    sha256 cellar: :any_skip_relocation, catalina:       "20a9e749b4e58e21d612f407dc19db7968307aeb3d1d259511eff0521ad44ea0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1af67942efccd31de611e9b688d5f94ed6d8d30e19d407907fe76eaacb428fa4"
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
