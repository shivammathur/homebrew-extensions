# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT74 < AbstractPhpExtension
  init
  desc "Gnupg PHP extension"
  homepage "https://github.com/php-gnupg/php-gnupg"
  url "https://pecl.php.net/get/gnupg-1.5.3.tgz"
  sha256 "c1555e0c86a7f6d95141530761c1ecf3fe8dbf76e14727e6f885cd7e034bdfd2"
  head "https://github.com/php-gnupg/php-gnupg.git"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/gnupg/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "1a5642757718f8292e96a6edba74bc45e127c9769c6e0423b21616f136e0705a"
    sha256 cellar: :any,                 arm64_sonoma:  "9ea4c4624318cc3dbe405219af442a65c9e256c35678ef56e4121dac4b0cbf28"
    sha256 cellar: :any,                 arm64_ventura: "1338d391e4ddcd1a6e040225f4881c011a348b21996afe7b57d06bbdd85cd7b6"
    sha256 cellar: :any,                 ventura:       "90a88d6f7fc8ac7701c90b071ab73fdd362a7b57c1aa611a3109799759ac20f9"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "dab45f98b4744310120acb88b4b7a61fdf1bf7a32afd5c60c22ece5d0d03af18"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "84520a2d6b91cfb9fb4108867e563d889da96c56a63f1e1cc31909e06749bc5e"
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
