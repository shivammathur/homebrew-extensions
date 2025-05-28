# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT80 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.4.1.tgz"
  sha256 "7bca5b23f731db9d8ed0aea5db9bb15da8ff133b0fbba96102b82e95da4d8764"
  head "https://github.com/php/pecl-networking-ssh2.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/ssh2/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "a4e84abe9767b30b479dba755acf818c4536cf2e3a89e8cf68cd67569ffb4ca7"
    sha256 cellar: :any,                 arm64_sonoma:   "a131d25948f08997a8e9ecd7ddb96a22532066daea100d1068d4076dd4d9d898"
    sha256 cellar: :any,                 arm64_ventura:  "fdd283451ee22b2774aba6f9b7d0144a88ae4f43a97e416e2913c51ef4329622"
    sha256 cellar: :any,                 arm64_monterey: "131e93ed4e4dd5c25930594a12795837f83b981d75f44392212fb3cf0341b66e"
    sha256 cellar: :any,                 ventura:        "b5a4aa9ca4a9001556b982aba773cb3b58fa6a711608f62734b821f628cdcc13"
    sha256 cellar: :any,                 monterey:       "2edd9240b1ecbf347d8ac6869d3836858f227e58b237411edc8f8602d1fc00df"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "8056bb02206e832c5bad3a8a0ff740eba595cbe5806716876202c8d6328db984"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5b210e34ac462491d0c5b9178a0917bdd73d19158bdf666919279dd2de5d8a95"
  end

  depends_on "libssh2"

  def install
    args = %W[
      --with-ssh2=shared,#{Formula["libssh2"].opt_prefix}
    ]
    Dir.chdir "ssh2-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
