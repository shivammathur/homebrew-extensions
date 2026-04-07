# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "ea6de4fa066761e1c3eb7ac2ffbd62cb1bbfd19b7bc3fa074616617c680f3734"
    sha256 cellar: :any,                 arm64_sequoia: "9aca91e2897ab53e7b23d38af77d56bb62242250250d381eb42c8352a71f15c4"
    sha256 cellar: :any,                 arm64_sonoma:  "d5a598a7fdf0a61a7c22a346d44d72ca1e9321a8a47b8d9a4c937c03389c7552"
    sha256 cellar: :any,                 sonoma:        "8d5e8c90ce3bd10afc4d95f3f8b21aa383a9a43172f4a9b4e545d93c7c52b083"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3582787712ff128bac2e9e9cfca721e552233a274edfb659cab59315af3c8746"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a331c4258bbd4df1a459310f5daef15c07fa181887a68d9d36dbade9a54da3fd"
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
