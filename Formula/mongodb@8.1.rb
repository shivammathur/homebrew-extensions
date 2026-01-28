# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.1.7.tgz"
  sha256 "0f46e64139569839b2becd30662a09843ffa9e99b8c4d006b2648a031a10fcc9"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "fbb1c5c65fcb759f0318fc3f717b986374d77d4794e561beebe13a9db511287b"
    sha256 cellar: :any,                 arm64_sequoia: "69b0d763a4ba31769fe2d58ab204891d90de730c8e4d2b8abc3f9c12d50a5c29"
    sha256 cellar: :any,                 arm64_sonoma:  "1b80c22954f0d79d19e6d50ce6190f076bfa779455c0eb2679ce247b65248365"
    sha256 cellar: :any,                 sonoma:        "723020445f612c3bf514e84d5e65ac6aa35ca45f269e09aa06a1c7ce20ad5f1c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7a32d07744168710a4dd4e88fba4379cedd82d85a0380b51139781262bf5cf6a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "14c9b5efff0750f1bf401a4a0a089e849ef38959c177b1bc57abd38f884dbcbf"
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
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
