# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT86 < AbstractPhpExtension
  init
  desc "Gnupg PHP extension"
  homepage "https://github.com/php-gnupg/php-gnupg"
  url "https://pecl.php.net/get/gnupg-1.5.4.tgz"
  sha256 "4d4a0980759bf259e4129ef02cb592bbeb103b4005e7b4bb6945d79488951a50"
  head "https://github.com/php-gnupg/php-gnupg.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/gnupg/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_tahoe:   "6c40bc0a40fb2273c7effaa970fddb20a78412ced635fb730ccc40b31704027f"
    sha256 cellar: :any,                 arm64_sequoia: "8bac0e918c0b8f86f864c4c8bb5d6d1398d4a86477759ee952ae22d53bfbb7ed"
    sha256 cellar: :any,                 arm64_sonoma:  "923a5b99b0d93b1f77132b4d34961e093b56164e1181b658223e24d178589bf8"
    sha256 cellar: :any,                 sonoma:        "049bf151f4a42c9fdba10ccca7a254bfb233ddc6a93ffd1b0b30d70fe52de680"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "155c3656b4f12211506a367df7867c1f97ff1e93d4c32c037000ee5fd33da286"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4437598410ee3e8770244befed24cfaf53533e93052b7ad9d144d7ca1250d090"
  end

  depends_on "gpgme"

  def install
    args = %W[
      --with-gnupg=#{Formula["gpgme"].opt_prefix}
    ]
    Dir.chdir "gnupg-#{version}"
    inreplace "phpc/phpc.h", "XtOffsetOf", "offsetof"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
