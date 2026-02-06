# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Maxminddb Extension
class MaxminddbAT74 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "23778c444dc5ea4feacf85050c599d17bae1d6d27cd4d3e9bbd15b73b036dae8"
    sha256 cellar: :any,                 arm64_sequoia: "2bbd1cc2717d879d78cc686373ea9b404b56ed6034ed3a4ba7379d0875becf54"
    sha256 cellar: :any,                 arm64_sonoma:  "57cb9139c97076412a51e322720d42985c9ed5f9aff3cdfa98be50f2a15aed62"
    sha256 cellar: :any,                 sonoma:        "00e3b0c65e7269feacd1c7b21a8d21d32378e5554c8532fc7f08319229adb4df"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7dacd6cb8d33d814f7fb9d4c6e0e0ad6a7ca9025e6c2d6d321235ebd2e582623"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8a39cdbe6824acbfad074bc19c4e18d1b819b53b880f4fe382dfbfb158bd76c0"
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
