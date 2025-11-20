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
  revision 4
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.7"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "7e926b7264deecbfb8e56ab6069512fd048ccbffda20a3e85b458c73ae1059f8"
    sha256 cellar: :any,                 arm64_sequoia: "1747dbea179b33ea46f481dcef35537b2d805a01de5d027f65f1774f784e959a"
    sha256 cellar: :any,                 arm64_sonoma:  "76c711170729f7dcca14d63ea65eaa16fdb1bae7d5e68b4a4c5fc9b0829486a3"
    sha256 cellar: :any,                 sonoma:        "3e38a78703ebaf280d97df3a20ff7d151a704282721b728ea08ec837b3807fab"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "90b2123707c81eebeaea022a435bc6de2d610d186522589e03bc1f278683a38a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a6f3e3e6bd2105f3ab9a6c8e24817c6e1765c733b85842f8fb3e3df867d47045"
  end

  depends_on "cyrus-sasl"
  depends_on "icu4c@78"
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
