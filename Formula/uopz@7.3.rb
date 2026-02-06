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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "c05ee7fba0d4d04b0837842aa64d38edc791f24046e37ef0b1a689a548ab41a0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2cfda04a2e5ad58ed198afb626854d635fbb478da014d1f081b35689a976fc37"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5d673212c19837ea26250403ca57b072717f7de4eb09056c62c7ef006dd1770d"
    sha256 cellar: :any_skip_relocation, sonoma:        "af08f7013ed62a31e05bdfa0948dc072430d103028ce8b32e87be97a420135dd"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "681fcfc1e1f11ee07bc61d4b0379d85a8669206942cf922735cc49563c76e8ac"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cd5384c09bb4f76d74abf7cf138ba329e4ca91516a2aaaf42e0fbaaf37b8c08c"
  end

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
