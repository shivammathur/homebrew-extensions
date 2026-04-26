# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT86 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.2.1.tgz"
  sha256 "b9f826c90c87e6abd74cc3a73132c025c03e4bd2ae4360c4edc822ff651d694d"
  revision 1
  head "https://github.com/php/pecl-networking-gearman.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/gearman/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "f0827a80a24c77eab6f6fb00bf7ba84b31344ec1015c1fb3c40438eed96ecdc0"
    sha256 cellar: :any,                 arm64_sequoia: "ae9d25c4e8abee0bfd03aafa59533a13bd73be8dd964076fde07cef00825f450"
    sha256 cellar: :any,                 arm64_sonoma:  "41c2d11b7c2295564e7424113b540044bb46468ac901fcaa06919b959e6622ab"
    sha256 cellar: :any,                 sonoma:        "e3443bc7cdfd7131ee97ea0a92c75ba2c5bba18ced447abfa4fb97ff2c9938de"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "970a8fb27a80c4d68f36d2fe5a5694b278ebb720e143cfb5bec2955be3ec7979"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b4111bb175e73f3941293309b179ad62ecdfe0a6c3b7fa15f38e69d2e76eb8b5"
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
