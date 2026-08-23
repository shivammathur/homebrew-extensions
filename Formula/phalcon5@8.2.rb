# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT82 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.20.0.tgz"
  sha256 "927caeda88334a33934d17b7d3b70ff46e0649e577f1339dc711bdb853290345"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "811d8e0d4be3ec02619e8e11003baefdc8d85573384bafb9a6eeb9a1336ef7d3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8e2099155409b34588b5da03d707ed584368adc653213516710eb771aa07298f"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3d5ba68a3bd81d229b6753939e35e24bb5fe3372d184724225e2b3777c39980a"
    sha256 cellar: :any_skip_relocation, sonoma:        "ca49b6736df0f5aaccdfc5f7da8a0ffd663bb9a4b3ee57d0c35902cbd4af652c"
    sha256 cellar: :any,                 arm64_linux:   "391afa01000e4fb80beee77c4a55983f7d21356e8ffc125ca78d6d8d45ecb494"
    sha256 cellar: :any,                 x86_64_linux:  "546704055a0f2d1a87f6cb3e09d1a29c62986a6a4e70ad792e9aafc49418703f"
  end

  depends_on "pcre"

  def install
    Dir.chdir "phalcon-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
