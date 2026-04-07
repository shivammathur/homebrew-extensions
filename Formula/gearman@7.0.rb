# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT70 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.2.1.tgz"
  sha256 "b9f826c90c87e6abd74cc3a73132c025c03e4bd2ae4360c4edc822ff651d694d"
  head "https://github.com/php/pecl-networking-gearman.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/gearman/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "5da741e172143aee03221dbcc256a4d6774cc37e6c3874a942095cb0e6ad9800"
    sha256 cellar: :any,                 arm64_sequoia: "273782a298c063e90801a5683a5d4738c7e9c4e4428528b2aeea9ee7067ad10e"
    sha256 cellar: :any,                 arm64_sonoma:  "cb23fcac39a504ded9db4d36e7ecc4ba28a331ffdc23e0c5a25559c5ada4d466"
    sha256 cellar: :any,                 sonoma:        "468fb5797c15aa52e8edde392d915d645bb6d8f2c1dd3d4f5eb329cf41eacae2"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "79a5728c91e4ea14162ba6762b92f3ef1a38d203b2e859034ff2efb8196a1342"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "71f37a687db80808d53d167764e1079c26a0d4028cb66280260719e174794635"
  end

  depends_on "gearman"

  def install
    args = %W[
      --with-gearman=#{Formula["gearman"].opt_prefix}
    ]
    Dir.chdir "gearman-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
