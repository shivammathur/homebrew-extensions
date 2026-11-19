# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Maxminddb Extension
class MaxminddbAT84 < AbstractPhpExtension
  init
  desc "MaxMind DB Reader PHP extension"
  homepage "https://github.com/maxmind/MaxMind-DB-Reader-php-ext"
  url "https://pecl.php.net/get/maxminddb-1.15.0.tgz"
  sha256 "49412f02d31d28861f56c05f043ed21a1e8c444b53ac47292da502a4d1fdaa2b"
  head "https://github.com/maxmind/MaxMind-DB-Reader-php-ext.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/maxminddb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "4735084a0299da747275b44f9355d3024e2ff5952e01633e1e1706d304e36a1e"
    sha256 cellar: :any, arm64_tahoe:       "e30f7e704d1c25b422b09d58ba00a331bbe56e433db5e1c7f3660adf8c38e3a2"
    sha256 cellar: :any, arm64_sequoia:     "18217784b356827bbf5ac5548eb5db24f996c2f43434d563952a7689e02aa125"
    sha256 cellar: :any, arm64_linux:       "e5c1be048321bf60420521964aee30a447652709090ecacd513b5002c2f610ad"
    sha256 cellar: :any, x86_64_linux:      "101af4d0ba5a57266d51af41942d2a5c2fdcae6f33e2aaabe742a9dec412f5c8"
  end

  depends_on "libmaxminddb"

  def install
    Dir.chdir "maxminddb-#{version}/ext"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-maxminddb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
