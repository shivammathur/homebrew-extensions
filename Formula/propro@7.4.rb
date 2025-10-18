# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Propro Extension
class ProproAT74 < AbstractPhpExtension
  init
  desc "Propro PHP extension"
  homepage "https://github.com/m6w6/ext-propro"
  url "https://pecl.php.net/get/propro-2.1.0.tgz"
  sha256 "7bba0653d90cd8f61816e13ac6c0f7102b4a16dc4c4e966095a121eeb4ae8271"
  head "https://github.com/m6w6/ext-propro.git", branch: "master"
  license "BSD-2-Clause"
  revision 1

  livecheck do
    url "https://pecl.php.net/rest/r/propro/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "32c04718d4125da99b464b8d0b88835bf92e90a99869a940989e0d770484622f"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "a53792c2aa180ca34b643964b2504ab0fd5d9ab59db5c6206148aebf12c247fa"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "ae2e92ba5b2e13f850a4aa018296c30008ba5774db44e23f3081f21a1c001931"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a95d2280977b1574d1bee77f07a2db4b0440a2e18f40dbf4cf15b4c7b0c21fd7"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "2c5bcc6b26ca174f88311de1f31a4bd617639906492efe199cad6d475221692d"
    sha256 cellar: :any_skip_relocation, sonoma:         "89c9a11aeb824ccc1837d2a6232e4833ae526d9e1cb36bb2dd7dcbf497a7df2e"
    sha256 cellar: :any_skip_relocation, ventura:        "7d48821228205fa2243455a7fab5d8898b34cc4392360458e680ad01efe60ad0"
    sha256 cellar: :any_skip_relocation, monterey:       "e98df1349adf3cd563c3593639eec5282b3d466ca9ba0458b401e2c8ba017134"
    sha256 cellar: :any_skip_relocation, big_sur:        "354a4c35a5d19a0a3c580458cc84468944ec1fc2ff0b8f6bf10732fc3be17cc7"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "3655da8c84afd046b7e93f6a0eb9e2503b67b3352befa437349bf416be7b1717"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7c4d33fde7e4e9228f2d09ce526faa33c996558e26f3931cf1ffc6f1de15f3f2"
  end

  def install
    Dir.chdir "propro-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-propro"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
