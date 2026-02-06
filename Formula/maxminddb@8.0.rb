# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Maxminddb Extension
class MaxminddbAT80 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "269b5e3da3382c406a98f8345e43446ac6c2b163a9432c576ec99af86a7c9811"
    sha256 cellar: :any,                 arm64_sequoia: "89461e5b3df70a187791d5d425c70b35bce45e32ccc9ea95382f3582b5aba347"
    sha256 cellar: :any,                 arm64_sonoma:  "130423730e742a188aeffcef063099fe7709863c09a66175a54dd0e3ad19cf67"
    sha256 cellar: :any,                 sonoma:        "b94609120b497a504518531ef12ab1317d6f0f7432bedbbd04bcd6cc218f3708"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "837b3587dc99e5a5e56ae702c8835f6e7ae1cc1938da644c696ef036d2efbeae"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4b9b12abf865305a35e4dca38d90858ac2490d6e320686571f299054a3a80dd2"
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
