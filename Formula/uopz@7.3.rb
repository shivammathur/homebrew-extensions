# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uopz Extension
class UopzAT73 < AbstractPhpExtension
  init
  desc "Uopz PHP extension"
  homepage "https://github.com/krakjoe/uopz"
  url "https://pecl.php.net/get/uopz-6.1.2.tgz"
  sha256 "d84b8a2ed89afc174be2dd2771410029deaf5796a2473162f94681885a4d39a8"
  head "https://github.com/krakjoe/uopz.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/uopz/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "4112fe606d5e6c1d8ff08d7349b66ef4257f741a62b2b9624bdb02810884fee2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "983d9ff6ae3aa445fd0781576c0527189fdc7019ebc2d7d0200c6954716b9416"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3b29e5717bb1d751f84488628a9e75702295db452abdc726a98d6d03335314e7"
    sha256 cellar: :any_skip_relocation, sonoma:        "85adffafbed7dfce7fa492aaad23800fe09e3153dc18115470c2f16e96edc04f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "45383d1683ef03732fa1832e843c1195c9dd96a9da366f959e0dff1f16634b26"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8139d47e107db1af760ce1437e87238cfafad784ce541b1b45118d5c38cbda0f"
  end

  priority "10"

  def install
    Dir.chdir "uopz-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-uopz"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
