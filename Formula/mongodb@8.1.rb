# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.20.0.tgz"
  sha256 "01e87973fe7e54aac52054ec4a99cdd439ed5c01f7e5b8ea0a57031850d8e75a"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.x"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "5870d04e6fc86eb1d0328a022db71929c69ea544cac82359945e9fdb93bfbf59"
    sha256 cellar: :any,                 arm64_sonoma:  "4f3994f059d62c48661191dd68347a0e7890311d85e6c648a280ecc350ab8244"
    sha256 cellar: :any,                 arm64_ventura: "9d0e1084ace0d4a3238c391c4c587014776de54cf41242131e62b86c86b4b849"
    sha256 cellar: :any,                 ventura:       "7e5f5c355693db4f6d896f19c175a51102745204ae569f702a4142560f773c80"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "722395fccf225fa871234d1baac0cd14e8464568ab164fce74bf4906d92b395a"
  end

  depends_on "icu4c"
  depends_on "openssl@3"
  depends_on "snappy"
  depends_on "zlib"
  depends_on "zstd"

  def install
    Dir.chdir "mongodb-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
