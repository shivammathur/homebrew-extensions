# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT85 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.15.tgz"
  sha256 "97772e6a0f2019eff7856522464e4432984f4fec470eaae14b807d70809b477c"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.21"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    manifest_sha256 "314525ab34b122b50b0e8f9f623dafc749be6f702146198724004a8c1257fc3b"
    sha256 cellar: :any, arm64_golden_gate: "1e5db61d556a6d367e5e42d1d246115be55cf03db967add650717dc80642baec"
    sha256 cellar: :any, arm64_tahoe:       "51b5c7c725afd4db8629cc532489a5d0f271bb8e987f7104f97c0dbecc037961"
    sha256 cellar: :any, arm64_sequoia:     "faa25f7d2cabc5914ec0052d7b18f64e733e453a153495fc4795da199761de06"
    sha256 cellar: :any, arm64_linux:       "202c63d59c1af4de68a29088f29e116d32ac4145de180985b72dbadf0f859ef1"
    sha256 cellar: :any, x86_64_linux:      "98c27af671b8c21e27508bb429b932109db67d124ae70b6226448eefbe7455fa"
  end

  depends_on "cyrus-sasl"
  depends_on "icu4c@78"
  depends_on "openssl@4"
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
