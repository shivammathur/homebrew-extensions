# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT71 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "23fd3c8a281a93c87e390ebf655e51618cedb2538c1e93c04c5eb38b83d9d2ec"
    sha256 cellar: :any,                 arm64_sequoia: "2f24bcd21a2cd3cc58a3d13acdf39e2e12a0f84dd8519f5b65c57e67bfd8a2d2"
    sha256 cellar: :any,                 arm64_sonoma:  "022e331b7032c0f6c250e1f3195a2c78ab84df4645a539b34b13b3d617d7ebf7"
    sha256 cellar: :any,                 sonoma:        "dd2e664d62f666be466ddea08f4aac71c8c1dddd5390cbb3486cf91f8dd41cf2"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "accd68c2239af9f7f5328dae0d24a33edb576c961aea5ac8e41fea43f7255ecf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "30aa0e65eb11cb74464559c15d4653ba9d718402b4e0dc98cc0b20ec5980fdd7"
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
