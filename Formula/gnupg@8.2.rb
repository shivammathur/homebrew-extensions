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
    sha256 cellar: :any,                 arm64_sequoia: "3579a7631f68d0cce390776dfc342d94cea16c0f89390efe13e0360ea54a8599"
    sha256 cellar: :any,                 arm64_sonoma:  "9490d5714bbdd78f071c3172fc5e41abbd6262aa3eda795137b777b99ad765f0"
    sha256 cellar: :any,                 arm64_ventura: "2166241a20ddc18cb73e0d7283104e98e2613b9e1ed2d20c2f224e2eae074c7a"
    sha256 cellar: :any,                 ventura:       "ab101c017b38ca082c59724fae97ef014cf90b6b74a1814b192f2c4a45b443d9"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9564626db1a0faf4d9e85a1d676c7ae5128cb0167e4194b7661d4adc279a8a9e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b65ad2713184bc1993e4eacbc29bbb5abd781b7446009737e262ef4e219a1e75"
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
