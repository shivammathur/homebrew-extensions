# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT84 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.5.0.tgz"
  sha256 "a943427fae39a5503c813179018ae6c500323c8c9fb434e1a9a665fb32a4d7b4"
  head "https://github.com/php/pecl-networking-ssh2.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/ssh2/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "e0103f8ee4983f4283546af3c083c11fbb72dee09151b3f989cfde54d94a94a4"
    sha256 cellar: :any,                 arm64_sequoia: "ad180b9c015fc00e45fe88258867693c2142aeb6de648bb8032ae569ad491064"
    sha256 cellar: :any,                 arm64_sonoma:  "4aeba95696ff78a54c62540335192a304f184dd1f3cc4e7943569e55a8ef982a"
    sha256 cellar: :any,                 sonoma:        "c64c4d0977abbd71bad3144510f06d72b09ade1e4f502b4fbb2f302c1cb41540"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "678527be0d31bbb5f2072fd95f44d039a6292a31ab6975007404106aa58ca3f1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "def97ae05f942263083a4ca6242511d5bb60bbaa377113ed73de4065a4ef1310"
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
