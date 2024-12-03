# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT84 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.24.tgz"
  sha256 "5c28a55b27082c69657e25b7ecf553e2cf6b74ec3fa77d6b76f4fb982e001e43"
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f55a8c638e5956f881107ac59925ac6bb291481c9a41e13a6a49eea646cd7246"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7ef0d4afd325aeed6301e919e37cd81035a3f25edff882744d88b3759f14e92b"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "71791decd68594f5f76b2bbc03d8d386cba4d931377cce474c0fe89665e2b3d4"
    sha256 cellar: :any_skip_relocation, ventura:       "338c4207ec396274c08d1e0c2df9d543c2c64f43ec04a695fa14504aa3234514"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f112d2eae9168073c9d72bc41fcff8c4a27706c113b194ba4c039e716238e37d"
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
