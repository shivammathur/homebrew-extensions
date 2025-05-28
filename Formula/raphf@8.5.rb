# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT85 < AbstractPhpExtension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.1.tgz"
  sha256 "da3566db17422e5ef08b7ff144162952aabc14cb22407cc6b1d2a2d095812bd0"
  head "https://github.com/m6w6/ext-raphf.git", branch: "master"
  license "BSD-2-Clause"
  revision 1

  livecheck do
    url "https://pecl.php.net/rest/r/raphf/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "88badf8fef35ae0e9c289abf41472982553093440da0561bdbae629d4e35650a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "012d878340e3abee979a6cd33add99c302ebdc19b708e64f7d6e97bae5fbcffb"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "0a990c84e571c26177718b3920f5598231e87a7390dfdbf48ef2cb7d9fd65ca9"
    sha256 cellar: :any_skip_relocation, ventura:       "006d79aff3c589b5f16f595a5ad6150c25cf0bf2325b2b9ebc78eb9ef583a90c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ff03a8844e32a4dbc8843633198ed6a108d6122a10033c564e0b86e6ead71741"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ef29ce16af7a92bdaa1e9dc4af05a0b51e197efaea4081cf6a9b810779d1b0fe"
  end

  def install
    Dir.chdir "raphf-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
