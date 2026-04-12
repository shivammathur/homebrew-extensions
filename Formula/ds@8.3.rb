# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT83 < AbstractPhpExtension
  init
  desc "Ds PHP extension"
  homepage "https://github.com/php-ds/ext-ds"
  url "https://pecl.php.net/get/ds-2.0.0.tgz"
  sha256 "52dfed624fbca90ad9e426f7f91a0929db3575a1b8ff6ea0cf2606b7edbc3940"
  head "https://github.com/php-ds/ext-ds.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/ds/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "8b9571a410c6cc568b62f5a7ff81c55db05de020b77b3a941db897e5fa47860b"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8109843f2f475bdfb13ebeeb6666c19e527264038187b94cdae8ed4e0bcd0dd1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b52342106c35b9b8e90588cede2eb3d00019cde90b880dd09e8590e9f570256c"
    sha256 cellar: :any_skip_relocation, sonoma:        "827c2130c159d311930f52be25a3103a93643ae7c342f2b9cad1c046d7f34067"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "8ee33e9321faa7b2ddbfb42c6b8cc64afb3c6a9fd4b7d301a8033bbc08b19050"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "19275ef014dd15c6b09ddb63b526631678d957112b454f6914d150235dbc8b5d"
  end

  priority "30"

  def install
    Dir.chdir "ds-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-ds"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
