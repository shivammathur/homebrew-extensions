# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://github.com/mongodb/mongo-php-driver.git",
      branch:   "master",
      revision: "b27fa4d01995fc3325ac4318d63d4c96d5d2660c"
  version "1.10.0"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_big_sur: "665734c8778d1ea331e81890a47edd0ccb0508cdb4fa3411c26066c3b50268ee"
    sha256 cellar: :any,                 big_sur:       "0d7e68b60c012447863ede442fde47fd5b46a1a7ff140ce52f3b62e5ceec7f92"
    sha256 cellar: :any,                 catalina:      "e8a260a3fcadfbbb4740a7f22cbda55473c3bece40fd15b0b9835fdfa1e601d9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "58ed5780cb2ce2f050f0160b92b5d2ab4970ebc967bc6b22130fcdefc3d1dfed"
  end

  depends_on "icu4c"
  depends_on "snappy"
  depends_on "zstd"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
