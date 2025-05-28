# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT81 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.24.tgz"
  sha256 "5c28a55b27082c69657e25b7ecf553e2cf6b74ec3fa77d6b76f4fb982e001e43"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e15062f210d162bf731e35dd4e0663132845829c0aae89cd6e9d19b86d076290"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "522d5d02c3e56f56688e6e7793a1f54ea627e4c0949b34b646a32d3508f7c0d0"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "726c95f9809ad874000d7e8902b3cd0807d4d68d0e2ed83ff8e8c792ebb2170b"
    sha256 cellar: :any_skip_relocation, ventura:       "c6baef6372e3caf1367f024d307029a647c65916f9e53a56a09a8e159245c26d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "106019cf15fc1c43cbb4ccce65f2fa5404585425960ee64800a7a158ee42e553"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0f603d52622605e137148c209645646ee5395f4be1fa90f8a04d6216ef09f214"
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
