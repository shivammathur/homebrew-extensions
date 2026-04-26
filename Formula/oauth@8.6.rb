# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Oauth Extension
class OauthAT86 < AbstractPhpExtension
  init
  desc "Oauth PHP extension"
  homepage "https://github.com/php/pecl-web_services-oauth"
  url "https://pecl.php.net/get/oauth-2.0.10.tgz"
  sha256 "1fd5e074dacf5149603493c454b476d69850bec0a71d7ea69a36a00db728a0fb"
  revision 1
  head "https://github.com/php/pecl-web_services-oauth.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/oauth/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "de07c04fe99d33be35a9bc5490249e91d870d6ec747ad784960016c553e405c1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1e3cff68c4b1bc49bc26d970964858c985da5d9773d2126ddd26c1028765eca5"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7c46a86e27bb474f04b1d7368cee489f13044ee97271b3d23aece62192c8831d"
    sha256 cellar: :any_skip_relocation, sonoma:        "c65ac3a67518ad254ca8c1b710ac3aedbec741ced56b56bcc0820ac5acd82808"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "65eaac6fe7eae9616425a6d07c951078d1d674cfa99a37e6daf42204d2940058"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8f40e1755cce6f8cc27c3979b9f6138c636c5b2fc0c544815f485cc02abe4ab8"
  end

  depends_on "curl"

  def install
    Dir.chdir "oauth-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-oauth"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
