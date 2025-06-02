# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT70 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "6ac6050d44c70f29c6eef2b850776ab945b39247bc39d5b0870c4a9ce437754b"
    sha256 cellar: :any,                 arm64_sonoma:  "222c40b55b7f78b40bc124e073a9158190e2392922edf33942f2ef781eb30c0b"
    sha256 cellar: :any,                 arm64_ventura: "e79623c8c6d13b085f010238c6149087eb78f98e11ae63be9f1c3d24737d36d5"
    sha256 cellar: :any,                 ventura:       "27ac96890eed971b836d803031e31b9f577eb305438bbf15f4ed55504e72c63f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "de8a404ff39406d6b115b9ab33b1151289ecccc2bfc489367813fe624d748082"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b3b4981c0e764525353cfecb4082508c52ab8a8eec7e34142fdf49b7962794dd"
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
