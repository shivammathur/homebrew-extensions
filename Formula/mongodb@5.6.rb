# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT56 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.7.5.tgz"
  sha256 "e48a07618c0ae8be628299991b5f481861c891a22544a2365a63361cc181c379"
  revision 3
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.7"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "bce964d924324b60b7bba592c681311f8c049711415ed0aecacf8192b5517231"
    sha256 cellar: :any,                 arm64_sonoma:  "fa3bdc4374217bcb2e8b3b511a08fc67ac7e3d83e83d4f9c91977a95a8ec5866"
    sha256 cellar: :any,                 arm64_ventura: "c48894f9297dae5ccb38c80184ec56fd3cc588f451446f71011656bc78995f7b"
    sha256 cellar: :any,                 sonoma:        "be722f00f632886b17aa6a2077cb142ff80649cd678d42162db97fff621019e5"
    sha256 cellar: :any,                 ventura:       "5d8e1ca0cb0ea4684211aba1240042ce62c9f45185744757db35f5de334b1720"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5dec2d344b24f005c77d74a3e5475612e93bca6b20b70c930443ad1ea0985c07"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "28043c2e6f85c71920e7c551061db383c59557458ae6e2e81d23c3637504513a"
  end

  depends_on "icu4c@77"
  depends_on "openssl@3"
  depends_on "snappy"

  uses_from_macos "zlib"

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
