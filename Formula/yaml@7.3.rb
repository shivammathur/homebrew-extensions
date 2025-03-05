# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT73 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-2.2.4.tgz"
  sha256 "8eb353baf87f15b1b62ac6eb71c8b589685958a1fe8b0e3d22ac59560d0e8913"
  head "https://github.com/php/pecl-file_formats-yaml.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/yaml/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "c972f532a640c4532ae890a8b1a74750e92aec8938da7f0c7459bfa7ed2c5646"
    sha256 cellar: :any,                 arm64_sonoma:  "72ad44c08c405cca8de9fdd8dd440f8fc4363d37d33fa4c30f01e05337b63d8f"
    sha256 cellar: :any,                 arm64_ventura: "cc002bc896f52d1f8a18f2171fc1a416b7cbe15a196b6645d70652df7d4638b1"
    sha256 cellar: :any,                 ventura:       "f867aa71a870a066bb23cf02041fd2b7d8cd8521253d5f1c504e7160b812bf96"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6106601400f12789146c9f38c3e979ce8d6a2e1f3fbc39d636ace798014edafa"
  end

  depends_on "libyaml"

  def install
    args = %W[
      --with-yaml=#{Formula["libyaml"].opt_prefix}
    ]
    Dir.chdir "yaml-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
