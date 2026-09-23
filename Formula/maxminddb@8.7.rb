# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Maxminddb Extension
class MaxminddbAT87 < AbstractPhpExtension
  init
  desc "MaxMind DB Reader PHP extension"
  homepage "https://github.com/maxmind/MaxMind-DB-Reader-php-ext"
  url "https://pecl.php.net/get/maxminddb-1.14.0.tgz"
  sha256 "c06351f1360bd651057ea73e0186d8fec744292839a4b49c71ce886072c4fff7"
  head "https://github.com/maxmind/MaxMind-DB-Reader-php-ext.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/maxminddb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "a3bcd574f6b31bf3465bb332fa2276de9fb6d5b87f57ee14f6cabdd8b72c442c"
    sha256 cellar: :any, arm64_tahoe:       "d07991253edcec434a31f35f2eb5ae7dc74af39678644bacfb6dc24ad9fb23b4"
    sha256 cellar: :any, arm64_sequoia:     "bbb4e1c6ca6b8722cb4775a37d4e8f820de2c57dd1ff5e7029f9ce65e7cd821f"
    sha256 cellar: :any, arm64_linux:       "b2f3664c2d65193c990122d7227d4a68eb1f3d0819a3ef2847443cc157892cc0"
    sha256 cellar: :any, x86_64_linux:      "43ffc356b8b56e172658212d47c06cb03440a1c673b09cddcce89fda652005ac"
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
