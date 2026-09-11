# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Maxminddb Extension
class MaxminddbAT80 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "04927f71dee22cdfdaf6a09e55b1a00af868d47ae9d6a9ce2f9d51160c776495"
    sha256 cellar: :any, arm64_sequoia: "9572093922498a26bb1546ce677906f14f46a21e0c18f3c29473f27302455f12"
    sha256 cellar: :any, arm64_sonoma:  "ae1500d11e64a204dcc4ace8db51afb626d9f931e2e6a90181501915788cfc60"
    sha256 cellar: :any, arm64_linux:   "a38b49f9b97bab5bdd8099cc94a5ac7be4b254c18fc1e642a05827c5f2468869"
    sha256 cellar: :any, x86_64_linux:  "d30eb3005b8e9716aa0b2a3290dc2d96fc52879433bae970efe17eaca27f9528"
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
