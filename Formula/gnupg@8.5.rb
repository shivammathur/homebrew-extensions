# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT85 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "6d60959d1c68728f0d1ba7608475f8748247980bd78893ace7ec8219558c2c8a"
    sha256 cellar: :any,                 arm64_sonoma:  "338b5f110ad5a4d9e5f265b08d80dafeecb2807084222c653bc11f06cf7c7cee"
    sha256 cellar: :any,                 arm64_ventura: "c8685fc92cfe9956bfa0c78ee43a7620c9e776299ffda7444cc56ae127ab4d84"
    sha256 cellar: :any,                 ventura:       "435ff846fe2076840342e0ab717f11048e37841afd0d7982e8fd60e137134086"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b4e51fc7a67307b86095504a20c21a14f7f3b1e85676b64586b79808b010f196"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cba87d643263c5ca24a62173873f69d8f067b318a57e98a4fbba70de8bc1a1ed"
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
