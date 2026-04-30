# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Maxminddb Extension
class MaxminddbAT86 < AbstractPhpExtension
  init
  desc "MaxMind DB Reader PHP extension"
  homepage "https://github.com/maxmind/MaxMind-DB-Reader-php-ext"
  url "https://pecl.php.net/get/maxminddb-1.13.1.tgz"
  sha256 "362839e6a0a50f6253d46ae11b3cae80520582e2b5528423aed9644577a3a93d"
  revision 1
  head "https://github.com/maxmind/MaxMind-DB-Reader-php-ext.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/maxminddb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_tahoe:   "f88679442b47cbcd6944b3b311935041ae73b34e9d1affed21156ec84df5a833"
    sha256 cellar: :any,                 arm64_sequoia: "32a9927d36ff76d6a7192ee223b95c1acc033dae9d2802dccbc9a8b1139440e0"
    sha256 cellar: :any,                 arm64_sonoma:  "231d74f349e4cf6156b5618d544ac6b4da303ba9e652c6c797084d9edb4de52c"
    sha256 cellar: :any,                 sonoma:        "a8fc5abd801db4114faae3700b00484ea56926ac6f0f010e2f36dd83e4256b55"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "76099a20ba4cd191dfa79d68dbf1ffd0ed08b2a0d6aca4ed60079db5722c7203"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "277d5f9fbd58144475c99b7e5c2bc6bd231700081180013a4b845bf60385a0dd"
  end

  depends_on "libmaxminddb"

  def install
    Dir.chdir "maxminddb-#{version}/ext"
    inreplace "maxminddb.c", "XtOffsetOf", "offsetof"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-maxminddb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
