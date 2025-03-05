# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT84 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.1.4.tgz"
  sha256 "1b16ae5e17736e2ce892fd96145fa8b9e1724106458535d0c7e3d4093a9091a9"
  head "https://github.com/php/pecl-networking-gearman.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/gearman/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "9dd7d59ad6a7f37973e72ec5c15bb2c9ce56ab9e6121e3c3530911047cb80c7d"
    sha256 cellar: :any,                 arm64_sonoma:  "1e47a34b03ad969274e90c6dfb5113c47d3c2f7ba428741ccf10a5a6d2230559"
    sha256 cellar: :any,                 arm64_ventura: "fe9cf5fc096d458cbfdfec9f884b1b124a5066b0bc716a2482704138f3711b05"
    sha256 cellar: :any,                 ventura:       "21d2a1b2fd038218ad92951a7032d6211466bfe77634ebea72a5a783b481917e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a49a78175f65db47d582f086b45664a58e0a7e23b88bacd61db17e090c818858"
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
