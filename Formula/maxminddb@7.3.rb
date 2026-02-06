# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Maxminddb Extension
class MaxminddbAT73 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "3e035c823b19bffc205ee5db89cee58e2912b17c21441557f0042b4027440be4"
    sha256 cellar: :any,                 arm64_sequoia: "b4cca0f131f552616c6a66b5ef2e44b459cd2e68c2a7bf003efa4b8568841b10"
    sha256 cellar: :any,                 arm64_sonoma:  "335d75ef4f85e6bf3af6bf367fb1b0be12d3199bce2e554b634293bf753e0a8f"
    sha256 cellar: :any,                 sonoma:        "7547810ff760d02b105e45587a9c500ca5d574e78063b92a51321f09d0636176"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "88efdbc676956e1b5af29fd808eac028e3686e5f7a40e90bb274072e0ef50783"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "166515bb9580befc5f26c846e5fa7e892206b70ae41976d894d5c3b796c0d497"
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
