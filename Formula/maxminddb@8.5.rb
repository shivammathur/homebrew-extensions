# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Maxminddb Extension
class MaxminddbAT85 < AbstractPhpExtension
  init
  desc "MaxMind DB Reader PHP extension"
  homepage "https://github.com/maxmind/MaxMind-DB-Reader-php-ext"
  url "https://pecl.php.net/get/maxminddb-1.13.1.tgz"
  sha256 "362839e6a0a50f6253d46ae11b3cae80520582e2b5528423aed9644577a3a93d"
  head "https://github.com/maxmind/MaxMind-DB-Reader-php-ext.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/maxminddb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "615f375c475daf9ec6deb370e9f55a1e9f096f961fbe9177d4a7567d65243643"
    sha256 cellar: :any,                 arm64_sequoia: "d722ff2a306773fe44719654dcbb6b62c4da53c888fa32b716ef78fb3222ebaa"
    sha256 cellar: :any,                 arm64_sonoma:  "6fe2283a7156d9ce2cb23d0cd735fa28742b94783d09abc5f1c64c50b9563cb3"
    sha256 cellar: :any,                 sonoma:        "837daa7c5790deddef2fbef88f88e5aa5a35a32caa50b17e36ed44a231e7e9f2"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b5448d9c9d6b3f5271746183debe2125533eed81006b576014515ec2b2f31007"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "13ac89856e9feb531bfd0962fe28ad580648f2cb736d9c9d8834263fa691e81a"
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
