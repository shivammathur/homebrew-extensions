# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Excimer Extension
class ExcimerAT80 < AbstractPhpExtension
  init
  desc "Excimer PHP extension"
  homepage "https://www.mediawiki.org/wiki/Excimer"
  url "https://pecl.php.net/get/excimer-1.2.6.tgz"
  sha256 "7b5fe1f68f2b1a62bd0394d4bf165eafe6b7ceb3fc20ab885e733d356db0d034"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/excimer/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "61f4ffba3a93a139f09b9076d80b8087ccd593e1177261a9171ca8cb1772c164"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "50f415e8ddcea990a61e8dd1e87de86d448fd388d98d4b30c10f440befd72c88"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "738c1388afc615ba2712c76d2f1e4c568c9adc36bcc18ef7851a49c428b47e5a"
    sha256 cellar: :any_skip_relocation, sonoma:        "4f3e3cfd3ecf293fe0bef45938d3927ebab188a14324ce02519d0c74bd4b608f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "de99bb0465339138fa867057f883883dfc8748c6b7d01c9efec760025522d05a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ee53f1f067a3b868347331c7e616a84cb78482669ad4bd29d209604575582311"
  end

  def install
    Dir.chdir "excimer-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-excimer"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
