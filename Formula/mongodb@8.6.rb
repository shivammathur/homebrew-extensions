# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT86 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.1.2.tgz"
  sha256 "01892642ba68f762b5a646f7e830d693e163a32b7e78c16e616df72c56ce3d2d"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "42c6c129f4fe3a93f2581efc9712a10c25630487400ecff780a75711d6045988"
    sha256 cellar: :any,                 arm64_sequoia: "8351d4d997ce06badb32b2de52e61a9b94d02bf1988c51fe7b796c459deb1e21"
    sha256 cellar: :any,                 arm64_sonoma:  "556fdb32825f6ebb8e79270ac05f8ec5fd50fffb4b8acb55fa45e31768276122"
    sha256 cellar: :any,                 sonoma:        "f02b58de2ecb36c5bbeab2bbeb0244d5485432685862dfc544f34729a3665fcb"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7bcae530732e9ed5044e72a06c9550fb0f9e147ac0231247a61586849238b726"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b0251b3b2d065e3fed582f26c2e0afba7352f513227afd07a42aec8052fd7fd7"
  end

  depends_on "cyrus-sasl"
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
