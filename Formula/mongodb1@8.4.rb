# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.1.tgz"
  sha256 "357e1f4f6b9f6f6970789f5186467da1960dff2db2a8d6474f69ad51a37b5f72"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "e100535a0466f7fcb207563e2636abe8e6348bc398ec94910bbe7dfb3b6a50a8"
    sha256 cellar: :any,                 arm64_sonoma:  "51fa456c7cdfca7c5d4ddee09c801c5840d39104d5775d98584fe716a1edfd27"
    sha256 cellar: :any,                 arm64_ventura: "9b42bbb64f06362c6ca365c692bee014c74d0f577bd4c6b3e48d2fb2999410ea"
    sha256 cellar: :any,                 ventura:       "b5894848960a5793ce99888ad430caf55af2d929d8b9951a1cd4d6bd4b829a87"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9481bc108492d39014011878234f73596e904e6206030d63b78f953e3bff4858"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cf41e3431858e587fde688a0f464a0beadc64720a8cf39dee39b7a10ff8b2809"
  end

  depends_on "icu4c@77"
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
    prefix.install "modules/mongodb.so"
    write_config_file
    add_include_files
  end
end
