# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT72 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.21.tgz"
  sha256 "1033530448696ee7cadec85050f6df5135fb1330072ef2a74569392acfecfbc1"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "da0491b24121f6910e24d9914f93000a4b5560a11244329136a29f40c684c9c5"
    sha256 cellar: :any_skip_relocation, big_sur:       "6ed02d732c4b94123f81022d63e806c3d6823552146b92771763a8f3ec37c11e"
    sha256 cellar: :any_skip_relocation, catalina:      "0fbacc769b1bbe360b91e994902f644399badd9d1a61e2d86d04703ec254f847"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4b06d0cb6582654c416f1b32d29e74ae05cd8122aa8140aef5c96d0f09cfff79"
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
