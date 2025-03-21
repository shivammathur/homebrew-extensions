# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT70 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.9.2.tgz"
  sha256 "95e832c5d48ae6e947bdc79f35a9f8f0bbd518f4aa00f1cef6c9eafbae02187d"
  revision 3
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.9"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_sequoia: "596f2a270409ea246b79792d12af398dfedc24138f90f1179d22013607c1a819"
    sha256 cellar: :any,                 arm64_sonoma:  "06ec896f4b20b4853e74af455fabb6fa99a7e53129f7128f28afcf7ac3aa9b6f"
    sha256 cellar: :any,                 arm64_ventura: "897b683e6fa59ca16314b137d533a305a956017560fa4bafa3652833e2cbf7eb"
    sha256 cellar: :any,                 ventura:       "2f2b6331a4e18db5dd909009ddddb4f0ac7e6c67954105d71cc00020c7dda24f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "93a759e78dd6e5216dfa6d6994abb11c9cb8d1ad19bb433d5836013a78bae6d9"
  end

  depends_on "icu4c@77"
  depends_on "openssl@3"
  depends_on "snappy"
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
