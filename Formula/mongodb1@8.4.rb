# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.9.tgz"
  sha256 "05045ef555d042991c6991d4439b85ebcaee5698f3733516f656508131d6e6c3"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.21"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "217f984776d8ad89d78160acccf7b85cdd06eb8d66235bd8de833fc865acb4fd"
    sha256 cellar: :any, arm64_sequoia: "27488a5de57c689a137073c3c3a659b862366652779039eae7db0d505a9a99ef"
    sha256 cellar: :any, arm64_sonoma:  "c904f281041853657eed0b1316976298b834550e02591cce69c8787cf45d4150"
    sha256 cellar: :any, arm64_linux:   "3b78908a0e89320743fb0f502ff141ccc5010b809ab2e72dab01392636449765"
    sha256 cellar: :any, x86_64_linux:  "910a24b460c3cc86af7fe68d11b019117d9f6f4a2893419957266683b2fa0087"
  end

  depends_on "cyrus-sasl"
  depends_on "icu4c@78"
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
