# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Oauth Extension
class OauthAT85 < AbstractPhpExtension
  init
  desc "Oauth PHP extension"
  homepage "https://github.com/php/pecl-web_services-oauth"
  url "https://pecl.php.net/get/oauth-2.0.10.tgz"
  sha256 "1fd5e074dacf5149603493c454b476d69850bec0a71d7ea69a36a00db728a0fb"
  head "https://github.com/php/pecl-web_services-oauth.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/oauth/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "82117a8b18851fd337af8bfb1ee2336e8f84c37c71ce0a4b0b0d3a63ec5c83d9"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "62b6af6d94a326cce1dc6cebafadd2ac96e12e9a4241f22a7f5534769d5e07e7"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "de3d1051b442d692670744de6c402f6a39e5f7a6f6324cc6846f953d8558b507"
    sha256 cellar: :any_skip_relocation, sonoma:        "c78de1ffec384a70a86f3c8e48fcb4aedc7a582d913056eea9b0c4e2a02151e1"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ac47f73061d9f4b3759ac37c2953bb474e36bbf9f06e243fb4947ece33a243c9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b3c65147b99d28d8d743896c2c57a474f3ca2503f7a6842580cf661820bcb708"
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
