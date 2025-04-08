# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT83 < AbstractPhpExtension
  init
  desc "Gnupg PHP extension"
  homepage "https://github.com/php-gnupg/php-gnupg"
  url "https://pecl.php.net/get/gnupg-1.5.2.tgz"
  sha256 "ad57aa23b3aef550fa4deddd003ff5322b886d55a67d1b020f5682ab829809fd"
  head "https://github.com/php-gnupg/php-gnupg.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/gnupg/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sequoia:  "d80bebeed934ba690960638564b0f84a5db1f4178cdb32150c6a59d78b9a270b"
    sha256 cellar: :any,                 arm64_ventura:  "96b9b68d4002d1038b7656388d5dd78dba4987bec335d3eab3410d02195e0618"
    sha256 cellar: :any,                 arm64_monterey: "242b3f3f94beff913234ec199c7188b7ffffa0d95925b8b2e7b765725a0c5332"
    sha256 cellar: :any,                 arm64_big_sur:  "170e153b0387ce3e2ce8bde1bc512c77175847be6fcf7864901b55c72177b0ae"
    sha256 cellar: :any,                 ventura:        "db09ac1a2b994882f70f0c3ba30d64ccb4642806660868c5fbf5e4f3574b7ef3"
    sha256 cellar: :any,                 monterey:       "a7159e918d57d4a3dab5473d298cd8f055b2d538c8aaba69332328451bce1000"
    sha256 cellar: :any,                 big_sur:        "1744225284c8fd77b85d4118f425467da1be8b212b5c399a0e4a449805eea90e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b34dca63ff1e43881d2edba45a77d4f59d2539066ef784d2f484c6af184d09dd"
  end

  depends_on "gpgme"

  def install
    args = %W[
      --with-gnupg=#{Formula["gpgme"].opt_prefix}
    ]
    Dir.chdir "gnupg-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
