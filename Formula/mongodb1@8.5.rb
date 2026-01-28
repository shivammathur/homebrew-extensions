# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT85 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.4.tgz"
  sha256 "ad299dfc4f69859acdb82d7eca5140833370dce31ebbe2c628e716ed3167b841"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.21"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "ed6de8745814a8fc84784e93d8e3b901ea82afc6c9cb7ba6fe069efb916391cd"
    sha256 cellar: :any,                 arm64_sequoia: "ca3c88ab36285e8c635e035fc057877f99f6640678abfb171139c4ea67c85269"
    sha256 cellar: :any,                 arm64_sonoma:  "9e3bfe829b897286e75de9ac171afaa718ecbda0730928b26e57768aa9dec63f"
    sha256 cellar: :any,                 sonoma:        "8432084b60651c0ff01bfc3108893e0c7e416a18b1181997ac9bfea330c73815"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d59bfe57216f851f71af0772c7e317e674938103a29b2c739239accdab81f35b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a25eafc0cdc7cb5f62a6a0f5a81cb064bb2192242b64cc00bc006d9da31ef6e7"
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
    inreplace "src/contrib/php_array_api.h", "IS_INTERNED", "ZSTR_IS_INTERNED"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/mongodb.so"
    write_config_file
    add_include_files
  end
end
