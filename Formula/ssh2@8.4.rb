# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT84 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.4.1.tgz"
  sha256 "7bca5b23f731db9d8ed0aea5db9bb15da8ff133b0fbba96102b82e95da4d8764"
  head "https://github.com/php/pecl-networking-ssh2.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/ssh2/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia: "4bb91b022bac0574c13326cb940ae42bbcac910114e1d8daea68e1c272ac54c8"
    sha256 cellar: :any,                 arm64_sonoma:  "51a5e04c72e4853ee211fd8b9b843f6f93507812d7d820f1fc724209a7e003a0"
    sha256 cellar: :any,                 arm64_ventura: "34e7350ce88324ae7bbc6fdbf7c60642f5a8d5ffb83b0dd87eb027a0fa1baf82"
    sha256 cellar: :any,                 ventura:       "ac415c921ea20156eb712c1a2affe8711e0a7f4bee9c22117662dc81ac56b1d2"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "bd6245cf110e573f766bfb947a99835f65b7424bac7148521356ab9fe8918e66"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a20622be76f1ca9e15a50240c4765c8f64dae6496a1a29ad8daa42974823d3ad"
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
