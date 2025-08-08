# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT82 < AbstractPhpExtension
  init
  desc "Gnupg PHP extension"
  homepage "https://github.com/php-gnupg/php-gnupg"
  url "https://pecl.php.net/get/gnupg-1.5.4.tgz"
  sha256 "4d4a0980759bf259e4129ef02cb592bbeb103b4005e7b4bb6945d79488951a50"
  head "https://github.com/php-gnupg/php-gnupg.git"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/gnupg/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "65958eadd0c27ee0c65608dccf565707fa5e937fed95f60ccfe955302b49701a"
    sha256 cellar: :any,                 arm64_sonoma:  "c46fb2da34576c78a56f275ecfc7c193832a5a251802fa1016e99caaf21c056e"
    sha256 cellar: :any,                 arm64_ventura: "69f68a8d4c948f297ca15acac55ab47b11e8d477fae281312b7121b6e4725352"
    sha256 cellar: :any,                 ventura:       "fc41e6b0861769e91bfa7375511c0fab0d42584bd837be77c32f2b0f6e9f9c02"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "83982e5756f47148dbf5d5f457d35b12af901c6dce7dd26f033f50ef35cfd168"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a53a91f7ed6fecd984824f9964e7cfe6b61de4cf3c14fea625a599c8c5165633"
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
