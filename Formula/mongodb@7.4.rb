# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT74 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.20.0.tgz"
  sha256 "01e87973fe7e54aac52054ec4a99cdd439ed5c01f7e5b8ea0a57031850d8e75a"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.20"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sequoia: "079b352ceea377cc60c427b86dc3133aacebfbe62652583d7be2017579c5b81c"
    sha256 cellar: :any,                 arm64_sonoma:  "1ef24f655c75da1f68f014b83d5263af1b96d508ff2bc8cc74c5754d63e61eea"
    sha256 cellar: :any,                 arm64_ventura: "a31aca9f1bf6847483c9bb0f1bfacb1022aae2916e78daa4c60dd1963bba1b12"
    sha256 cellar: :any,                 ventura:       "4ea16eb2c93c431f781fe9970b3545f82e6dd886f5edb67fe971aa9e0afe959a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4f69edc1ca8ea37fa6b6d012d4f6d10310fd03c9955b030f89cc982ca2ab8538"
  end

  depends_on "icu4c@76"
  depends_on "openssl@3"
  depends_on "snappy"
  depends_on "zlib"
  depends_on "zstd"

  def install
    # Work around to support `icu4c` 75, which needs C++17.
    ENV.append "CXX", "-std=c++17"
    ENV.libcxx if ENV.compiler == :clang
    Dir.chdir "mongodb-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
