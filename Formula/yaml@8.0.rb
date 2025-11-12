# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT80 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-2.3.0.tgz"
  sha256 "bc8404807a3a4dc896b310af21a7f8063aa238424ff77f27eb6ffa88b5874b8a"
  head "https://github.com/php/pecl-file_formats-yaml.git", branch: "php7"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/yaml/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "7535d93832bbe9f5c2449479cbc7985ec76ba01dc632913b1c8c17882cefea78"
    sha256 cellar: :any,                 arm64_sequoia: "f209066ce10b488d8f32516ec2ec9e892d487dc96752d51919f5a24b99cc5f9a"
    sha256 cellar: :any,                 arm64_sonoma:  "600a6e3c209c050b282bd507f206b50c105a226350b1213a86ad8db1b04f14fe"
    sha256 cellar: :any,                 sonoma:        "67b40799dc70a62f854e99f29325b298fcea87368070705ea2a71944f2454203"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4251e9d7581f9c78ad021ce3265c60e9b05535a90dec2ecdafb6ad9cdec2749b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e81ffd29ecdfa581fa6354d5c1d341baf62ac68a35e5792235ea04b1b1d47cc0"
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
