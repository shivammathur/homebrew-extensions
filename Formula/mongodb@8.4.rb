# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.1.0.tgz"
  sha256 "2717abd81cdff4a1ed1f08d9f77d9c3601a9d934e89bc5441617f7c0acd62d17"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "f9c2e07f72951ddd7afa2451b91de86324bd46012788afde7fe75e47df88b1cc"
    sha256 cellar: :any,                 arm64_sonoma:  "6beab53c76571cce5ff5dc1c490d4b2b25a8d4f8779407aa57bf8a01bdc799c6"
    sha256 cellar: :any,                 arm64_ventura: "f8393a8556207d674712ae0970a93e1cb1b3f5cc4d283ce938710ffe36af827f"
    sha256 cellar: :any,                 ventura:       "2a492deacdb6e70c2f2ebf0f1420d137923747aedd9329dcfe967499e32b1e5d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b4eec5201744209480add8f11206f850ed32b235f73cc684393360d500502539"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "03db2a3d7dcdaa2bac155b7dd206bf18a615fccebf289cfcabfecca6c6aca2ba"
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
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
