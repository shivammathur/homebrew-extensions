# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT73 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.21.tgz"
  sha256 "1033530448696ee7cadec85050f6df5135fb1330072ef2a74569392acfecfbc1"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "f8838a9b68b4a7093e27859ccbd9a47ea67796d82d3782dc6b03b3e58b73c2bc"
    sha256 cellar: :any_skip_relocation, big_sur:       "45e8b065a40b5a4e0c90fe7f7a8fc87ca56c6fed3ecf93d70844e312af6111c7"
    sha256 cellar: :any_skip_relocation, catalina:      "9ed902ba612d3af63e2a6e77e7f3d0db08de47ff326834040a221b58557e81d1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0d306487a435c5e483c6c7c17ad24e8103fdd82da8298b11211d32a377172085"
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
